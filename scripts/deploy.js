const main = async () => {
  const jokeContractFactory = await hre.ethers.getContractFactory("JokePortal");
  const jokeContract = await jokeContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await jokeContract.deployed();

  console.log("JokePortal address:", jokeContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
