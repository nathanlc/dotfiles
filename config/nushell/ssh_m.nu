def config_category_string [cat: record] {
  let build_line = { |key, value|
    $"($key) ($value)"
  }
  (
    $cat |
    transpose key value |
    each { |it|
      match [$it.key, $it.value] {
        ["host", $v] => (do $build_line "Host" $v),
        ["host_list", _] => null,
        [_, null] => null,
        [$k, $v] => (match ($v | describe | str replace --regex '<.*' '') {
          "list" => ($v | each { |x| (do $build_line $"  ($k)" $x) }),
          _ => (do $build_line $"  ($k)" $v)
        })
      }
    } |
    flatten |
    compact
  )
}

export def update_hostname_ip [conf host ip] {
  (
    $conf |
    upsert hostname { |row| (if ($row.host == $host) { $ip } else { $row.hostname? }) }
  )
}

export def config_string [conf] {
  (
    $conf |
    each { |it|
      (
        config_category_string $it |
        str join "\n"
      )
    } |
    str join "\n\n"
  )
}

export def config_from_file [] {
  (
    cat ~/.ssh/config |
    jc --ssh-conf |
    from json
  )
}
