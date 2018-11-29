var BallondOr = artifacts.require("BallondOr.sol");

contract("BallondOr", function() {

  // chai assertion library: https://www.chaijs.com/api/assert/

  var ballondorInstance;
  var candidateId;
  var account;

  // testar inicialização de 6 candidatos
  it("Inicializa 6 candidatos", function() {
    /* testar:
        - número correto de candidatos inicializados
    */
    return BallondOr.deployed().then(function(instance) {
      ballondorInstance = instance;
      return ballondorInstance.totalCandidates();
    }).then(function(totalCandidates) {
      assert.equal(totalCandidates, 6);
    });
  });

  // testar inicialização correta dos 6 candidatos
  it("Inicializa os 6 candidatos com os valores corretos", function() {
    /* testar:
        - inicialização correta dos 3 valores de cada candidato
    */
    return BallondOr.deployed().then(function(instance) {
      ballondorInstance = instance;
      return ballondorInstance.candidates(1);
    }).then(function(candidate) {
      assert.equal(candidate[0], 1);
      assert.equal(candidate[1], "Lionel Messi");
      assert.equal(candidate[2], 0);
      return ballondorInstance.candidates(2);
    }).then(function(candidate) {
      assert.equal(candidate[0], 2);
      assert.equal(candidate[1], "Cristiano Ronaldo");
      assert.equal(candidate[2], 0);
      return ballondorInstance.candidates(3);
    }).then(function(candidate) {
      assert.equal(candidate[0], 3);
      assert.equal(candidate[1], "Neymar Jr");
      assert.equal(candidate[2], 0);
      return ballondorInstance.candidates(4);
    }).then(function(candidate) {
      assert.equal(candidate[0], 4);
      assert.equal(candidate[1], "Kylian Mbappe");
      assert.equal(candidate[2], 0);
      return ballondorInstance.candidates(5);
    }).then(function(candidate) {
      assert.equal(candidate[0], 5);
      assert.equal(candidate[1], "Luka Modric");
      assert.equal(candidate[2], 0);
      return ballondorInstance.candidates(6);
    }).then(function(candidate) {
      assert.equal(candidate[0], 6);
      assert.equal(candidate[1], "Mohammed Salah");
      assert.equal(candidate[2], 0);
    });
  })

  // testar o registro de um voto
  it("Registra corretamente o voto", function() {
    /* testar:
        - candidato recebeu 1 voto a mais do que tinha anteriormente
        - hasAddressVoted foi marcado como true
        - evento Voted foi emitido
    */
    return BallondOr.deployed().then(function(instance) {
      ballondorInstance = instance;
      candidateId = 1;
      account = web3.eth.accounts[0];
      return ballondorInstance.vote(candidateId, { from: account });
    }).then(function(receipt) {
      /* verificar:
          - que há um evento registrado no log
          - que o evento registado foi o correto
          - que o argumento passado foi o correto
      */
      assert.equal(receipt.logs.length, 1);
      assert.equal(receipt.logs[0].event, 'Voted');
      assert.equal(receipt.logs[0].args._candidateId, '1');
      return ballondorInstance.hasAddressVoted(account);
    }).then(function(voted) {
      assert.equal(voted, true);
      return ballondorInstance.candidates(candidateId);
    }).then(function(candidate) {
      assert.equal(candidate[2].toNumber(), 1);
    });
  });

  // testar lançamento de exceção para voto em candidato inválido
  it("Lança exceção para voto em candidato inválido", function() {
    BallondOr.deployed().then(function(instance) {
      ballondorInstance = instance;
      return ballondorInstance.vote(79, { from: account });
    }).then(assert.fail).catch(function(error) {
      assert(error.message.indexOf('revert') >= 0);
    });
  });

  // testar lançamento de exceção para voto duplo do mesmo endereço

});
