const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const jokeContractFactory = await hre.ethers.getContractFactory("JokePortal");
  const jokeContract = await jokeContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await jokeContract.deployed();
  console.log("Contract addy:", jokeContract.address);

  // Get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    jokeContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // Send Joke
  let jokeTxn = await jokeContract.joke("So that chicken crossed the road...");
  await jokeTxn.wait(); // Wait for the transaction to be mined.

  contractBalance = await hre.ethers.provider.getBalance(jokeContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allJokes = await jokeContract.getAllJokes();
  console.log(allJokes);
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
