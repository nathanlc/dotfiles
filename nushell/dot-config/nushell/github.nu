def checkout_pr_in_worktree [repo: string, dir: string, pr: int] {
  cd $dir
  let pr_branch = $"pr-($pr)"
  let worktree = $"../($repo)-($pr_branch)"
  if ($worktree | path exists) {
    print $"Worktree already exists: '($worktree)'"
    return
  }
  git worktree add $worktree -b $pr_branch
  cd $worktree
  git stash
  gh pr checkout $pr
  print $"Created worktree for PR: '($worktree)'"
}

export def worktrees_for_prs [] {
  let git_dirs = (
      fd --hidden --max-depth 3 --type d ^.git$ ~/sandbox |
      lines |
      path dirname |
      wrap path |
      upsert repo { |it| $it | get path | path basename }
  )
  (
    gh search prs --state=open --review-requested=@me --json number,repository |
    from json |
    update repository { |it| $it.repository.name } |
    upsert dir { |pr| $git_dirs | where { |it| $it.repo == $pr.repository } | get path.0 } |
    each { |res| checkout_pr_in_worktree $res.repository $res.dir $res.number }
  )
}
