const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const jokeContractFactory = await hre.ethers.getContractFactory("JokePortal");
  const jokeContract = await jokeContractFactory.deploy();
  await jokeContract.deployed();
  console.log("Contract deployed to:", jokeContract.address);
  console.log("Contract deployed by:", owner.address);

  let jokeCount;
  jokeCount = await jokeContract.getTotalJokes();
  console.log(jokeCount.toNumber());

  // Send transaction by owner
  let jokeTxn = await jokeContract.joke("So that chicken crossed the road...");
  await jokeTxn.wait(); // Wait for the transaction to be mined.

  // Send transaction by randomPerson
  jokeTxn = await jokeContract.connect(randomPerson).joke("knock knock!");
  await jokeTxn.wait();

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
