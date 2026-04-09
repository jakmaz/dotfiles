#!/usr/bin/env nu

def main [cmd: string] {
    let parts = ($cmd | split row ' ')
    let url = ($parts | each {|x| if ($x | str starts-with 'http') { $x } } | compact | get 0)
    let skill_idx = ($parts | enumerate | where {|e| $e.item == '--skill'} | get 0 | get index)
    if $skill_idx == null {
        print 'Error: --skill flag not found'
        exit 1
    }
    let skill_name = ($parts | get ($skill_idx + 1))

    let target_dir = $'($env.HOME)/git/dotfiles/opencode/skill/($skill_name)'
    let source_dir = $'($env.HOME)/.agents/skills/($skill_name)'

    print $'Adding skill \'($skill_name)\' from ($url)...'

    print $'Running: bunx skills add ($url) --skill ($skill_name) --agent opencode --global --yes'
    ^bunx skills add $url --skill $skill_name --agent opencode --global --yes

    if (($source_dir | path type) != 'dir') {
        print $'Error: Source skill not found at ($source_dir)'
        exit 1
    }

    mkdir $target_dir
    run-external "cp" "-r" $"($source_dir)/." $target_dir
    print $'Copied to ($target_dir)'

    print $'Done! Skill \'($skill_name)\' installed and added to dotfiles.'
}
