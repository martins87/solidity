var BallondOr = artifacts.require("./BallondOr.sol");

contract("BallondOr", function() {

  var ballondOrInstance;
  var candidateId;
  var account;

  it("Inicializa seis candidatos", function() {
    /* testar:
        - número correto de candidatos inicializados
    */
    return BallondOr.deployed().then(function(instance) {
      ballondOrInstance = instance;
      return ballondOrInstance.totalCandidates();
    }).then(function(totalCandidates) {
      assert.equal(totalCandidates, 6, "Inicializou incorretamente o número de candidatos");
    });
  });

  it("Instancializa os candidatos com os valores corretos", function() {
    /* testar:
        - valores inicializados corretamente
    */
    return BallondOr.deployed().then(function(instance) {
      ballondOrInstance = instance;
      return ballondOrInstance.candidates(1);
    }).then(function(candidate) {
      assert.equal(candidate[0], 1);
      assert.equal(candidate[1], "Lionel Messi");
      assert.equal(candidate[2], 0);
      return ballondOrInstance.candidates(2);
    });
  });

  it("Verifica voto correto em um candidato", function() {
    /* testar 3 coisas:
        - evento disparado
        - número de votos do candidato é o esperado
        - hasAddressVoted foi marcado como true
    */
    return BallondOr.deployed().then(function(instance) {
      ballondOrInstance = instance;
      account = web3.eth.accounts[0];
      candidateId = 1;
      return ballondOrInstance.vote(candidateId, { from: account });
    }).then(function(receipt) {
      assert.equal(receipt.logs.length, 1);
      assert.equal(receipt.logs[0].event, "Voted");
      //console.log(receipt.logs[0].args._candidateId.toNumber());
      assert.equal(receipt.logs[0].args._candidateId, 1);
      return ballondOrInstance.hasAddressVoted(account);
    }).then(function(voted) {
      assert.equal(voted, true);
      return ballondOrInstance.candidates(candidateId);
    }).then(function(candidate) {
      assert.equal(candidate[2], 1);
    });
  });

  // testar revert() em voto em candidato inválido

  // testar exceção para voto duplo

});
