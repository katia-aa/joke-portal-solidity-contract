const main = async () => {
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
  let jokeTxn2 = await jokeContract.joke(
    "The chicken didn't make it to the other side of the road..."
  );
  await jokeTxn2.wait(); // Wait for the transaction to be mined.

  contractBalance = await hre.ethers.provider.getBalance(jokeContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // Laugh at a Joke
  let laughTxn = await jokeContract.laugh(
    "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"
  );
  await laughTxn.wait();
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
