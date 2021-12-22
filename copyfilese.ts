async function main() {
  await Deno.copyFile(".tmux.conf", "./heyehey/.tmux.conf");
}

main();
