-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hangman
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hangman
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hangman` DEFAULT CHARACTER SET utf8 ;
USE `hangman` ;

-- -----------------------------------------------------
-- Table `hangman`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`roles` ;

CREATE TABLE IF NOT EXISTS `hangman`.`roles` (
  `id` TINYINT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del rol',
  `role` VARCHAR(45) NOT NULL COMMENT 'Descripción del rol',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`users` ;

CREATE TABLE IF NOT EXISTS `hangman`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id del usuario',
  `email` VARCHAR(60) NOT NULL COMMENT 'Email del usuario (será su nombre de usuario para login).',
  `password` VARCHAR(12) NOT NULL COMMENT 'Contraseña del usuario',
  `name` VARCHAR(60) NOT NULL COMMENT 'Nombre de pila del usuario',
  `lastname` VARCHAR(100) NULL COMMENT 'Apellidos del usuario',
  `school` VARCHAR(100) NULL COMMENT 'Nombre del plantel donde labora el usuario (opcional)',
  `idavatar` INT NOT NULL DEFAULT 0 COMMENT 'Id del avatar seleccionado (0 = avatar por defecto)',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de la fecha-hora de creción del usuario',
  `roles_id` TINYINT NOT NULL COMMENT 'Id del rol del usuario',
  PRIMARY KEY (`id`, `email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`words`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`words` ;

CREATE TABLE IF NOT EXISTS `hangman`.`words` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id de la palabra (verbo)',
  `erased` BIT NOT NULL DEFAULT 0 COMMENT '¿La palabra está borrada?',
  `word` VARCHAR(30) NOT NULL COMMENT 'Palabra (verbo)',
  `type` VARCHAR(1) NOT NULL COMMENT 'Tipo de verbo [R]egular o [I]rregular',
  `clue` VARCHAR(300) NOT NULL COMMENT 'Pista para adivinar la palabra',
  `simplepast` VARCHAR(30) NOT NULL COMMENT 'Pasado simple de la palabra (verbo)',
  `example` VARCHAR(300) NULL COMMENT 'Ejemplo de uso de la palabra (oración en pasado simple)',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de la creación de la palabra (fecha, hora:minutos:segundos)',
  `user_id` INT NOT NULL COMMENT 'Id del usuario creador de la palabra',
  PRIMARY KEY (`id`, `user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`room` ;

CREATE TABLE IF NOT EXISTS `hangman`.`room` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id de la sala creada por un usuario',
  `roomname` VARCHAR(50) NOT NULL COMMENT 'Nombre de la sala',
  `description` VARCHAR(300) NULL COMMENT 'Descripción de la sala',
  `lives` INT NOT NULL DEFAULT -1 COMMENT 'Número de vidas de la sala -1 = ilimitadas',
  `clue` BIT NOT NULL DEFAULT 1 COMMENT '¿Se mostrará la pista al jugador? 1 = sí 0 = no',
  `clueafter` TINYINT NOT NULL DEFAULT 3 COMMENT 'Mostrar pista después del error número: (1-5). -1 = no se muestra pista',
  `feedback` BIT NOT NULL DEFAULT 1 COMMENT '¿Se mostrará retroalimentación al jugador? 1 = sí 0 = no',
  `random` BIT NOT NULL DEFAULT 0 COMMENT '¿Se mostrarán a los jugadores las palabras en orden aleatorio? 1 = sí 0 = no',
  `isopen` BIT NOT NULL DEFAULT 1 COMMENT '¿La sala está abierta? 1 = sí 0 = no',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de la fecha y hora de creación de la sala',
  `roomcode` VARCHAR(6) NOT NULL COMMENT 'Código de la sala, se genera automaticamente y no debe repetirse',
  `qrstring` VARCHAR(300) NULL COMMENT 'Cadena de caracteres para generar el código QR',
  `user_id` INT NOT NULL COMMENT 'Id del usuario que creó la sala',
  PRIMARY KEY (`id`, `user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`room_has_words`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`room_has_words` ;

CREATE TABLE IF NOT EXISTS `hangman`.`room_has_words` (
  `room_id` INT NOT NULL COMMENT 'Id de la sala',
  `word_id` INT NOT NULL COMMENT 'Id de la palabra',
  `used` INT NOT NULL DEFAULT 0 COMMENT 'Número de veces que la palabra ha sido usada.',
  `guessed` INT NOT NULL DEFAULT 0 COMMENT 'Número de veces que la palabra ha sido adivinada.',
  `typefails` INT NOT NULL DEFAULT 0 COMMENT 'Número de veces que se ha fallado al adivinar el tipo de este verbo',
  `pastfails` INT NOT NULL DEFAULT 0 COMMENT 'Número de veces que se ha fallado al adivinar el pasado simple del verbo',
  `clue` VARCHAR(300) NOT NULL COMMENT 'Pista personalizada de este verbo. Colocar por defecto la pista original.',
  `example` VARCHAR(300) NOT NULL COMMENT 'Ejemplo personalizado de este verbo. Colocar por defecto el ejemplo original.',
  PRIMARY KEY (`room_id`, `word_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`roomgame`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`roomgame` ;

CREATE TABLE IF NOT EXISTS `hangman`.`roomgame` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id del juego de sala',
  `player` VARCHAR(100) NOT NULL COMMENT 'Nombre del jugador',
  `score` INT NOT NULL DEFAULT -1 COMMENT 'Puntuación final del jugador. -1 = se rindió',
  `room_id` INT NOT NULL COMMENT 'Id de la sala en que se unió el jugador para jugar',
  `totaltime` TIME NOT NULL DEFAULT 0 COMMENT 'Timpo total que el jugador jugó en la sala',
  `timestampstart` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de la fecha-hora de inicio de juego en la sala',
  `timestampend` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de la fecha-hora de término de juego en la sala',
  PRIMARY KEY (`id`, `room_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`roomgamedetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`roomgamedetails` ;

CREATE TABLE IF NOT EXISTS `hangman`.`roomgamedetails` (
  `roomgame_id` INT NOT NULL COMMENT 'Id de la sala',
  `word_id` INT NOT NULL COMMENT 'Id de la palabra (verbo) que existe en la sala',
  `guessed` BIT NOT NULL DEFAULT 0 COMMENT '¿El jugador adivinó las letras de la palabra? 1 = sí 0 = no',
  `typecorrect` BIT NOT NULL DEFAULT 0 COMMENT '¿El jugador adivinó el tipo de verbo de la palabra? 1 = sí 0 = no',
  `pastcorrect` BIT NOT NULL DEFAULT 0 COMMENT '¿El jugador adivinó el pasado simple de la palabra? 1 = sí 0 = no',
  `timeperword` TIME NOT NULL DEFAULT 0 COMMENT 'Tiempo en que el jugador invirtió jugando esa palabra hh:mm:ss',
  `pointsperword` INT NOT NULL DEFAULT 0 COMMENT 'Puntos que el jugador obtuvo en esta palabra',
  PRIMARY KEY (`roomgame_id`, `word_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`arenagame`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`arenagame` ;

CREATE TABLE IF NOT EXISTS `hangman`.`arenagame` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id del juego en arena',
  `player` VARCHAR(100) NOT NULL COMMENT 'Nombre del jugador en arena',
  `score` INT NOT NULL DEFAULT 0 COMMENT 'Puntuación final del jugador en arena. -1 si se rindió (no acumula puntos)',
  `totaltime` TIME NOT NULL COMMENT 'Tiempo total que el jugador jogó en arena',
  `timestampstart` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de fecha/hora en que el jugador inició su juego en arena',
  `timestampend` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TimeStamp de fecha/hora en que el jugador terminó su juego en arena (o se rindió)',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hangman`.`arenagame_has_words`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hangman`.`arenagame_has_words` ;

CREATE TABLE IF NOT EXISTS `hangman`.`arenagame_has_words` (
  `arenagame_id` INT NOT NULL COMMENT 'Id del juego en arena',
  `word_id` INT NOT NULL COMMENT 'Palabra que se generó para este juego de arena',
  PRIMARY KEY (`arenagame_id`, `word_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hangman`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `hangman`;
INSERT INTO `hangman`.`roles` (`id`, `role`) VALUES (DEFAULT, 'Administrator');
INSERT INTO `hangman`.`roles` (`id`, `role`) VALUES (DEFAULT, 'Teacher');
INSERT INTO `hangman`.`roles` (`id`, `role`) VALUES (DEFAULT, 'Student');
INSERT INTO `hangman`.`roles` (`id`, `role`) VALUES (DEFAULT, 'Other');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hangman`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `hangman`;
INSERT INTO `hangman`.`users` (`id`, `email`, `password`, `name`, `lastname`, `school`, `idavatar`, `timestamp`, `roles_id`) VALUES (DEFAULT, 'hangmanadmin@cbtis150.edu.mx', 'Adm1n$', 'Administrador de proyecto hangman', NULL, 'CBTis No. 150', 0, DEFAULT, 1);
INSERT INTO `hangman`.`users` (`id`, `email`, `password`, `name`, `lastname`, `school`, `idavatar`, `timestamp`, `roles_id`) VALUES (DEFAULT, 'rober.rume@gmail.com', 'Ab1$', 'Roberto', 'Ruiz Mendoza', 'CBTis No. 150', 0, DEFAULT, 2);
INSERT INTO `hangman`.`users` (`id`, `email`, `password`, `name`, `lastname`, `school`, `idavatar`, `timestamp`, `roles_id`) VALUES (DEFAULT, 'teacheryuriml@gmail.com', 'Ab1$', 'Elva Yuridia', 'Morales Luis', 'CBTis No. 150', 0, DEFAULT, 2);
INSERT INTO `hangman`.`users` (`id`, `email`, `password`, `name`, `lastname`, `school`, `idavatar`, `timestamp`, `roles_id`) VALUES (DEFAULT, 'angelafloxz@gmail.com', 'Ab1$', 'Angela', 'Flores Díaz', 'CBTis No. 150', 0, DEFAULT, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hangman`.`words`
-- -----------------------------------------------------
START TRANSACTION;
USE `hangman`;
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'AWAKE', 'I', 'It is the opposite of sleeping.', 'Awoke', 'Example of Awoke (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BEAT', 'I', 'To strike forcefully and repeatedly.', 'Beat', 'Example of Beat (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BITE', 'I', 'It is an act that is done when eating.', 'Bit', 'Example of Bit (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BLOW', 'I', 'It is the synonym of burst.', 'Blew', 'Example of Blew (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BREAK', 'I', 'When you fracture something.', 'Broke', 'Example of Broke (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BROADCAST', 'I', 'To transmit from a radio station.', 'Broadcast', 'Example of Broadcast (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BUILD', 'I', 'When you put block with cement to do a house.', 'Built', 'Example of Built (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BURN', 'I', 'To cause to be on fire.', 'Burnt', 'Example of Burnt (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CHOOSE', 'I', 'When you select something that you like.', 'Chose', 'Example of Chose (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CUT', 'I', 'You use a knife to do it.', 'Cut', 'Example of Cut (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DIG', 'I', 'You use a shovel to do this.', 'Dug', 'Example of Dug (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DREAM', 'I', 'When you sleep you can feel it.', 'Dreamt', 'Example of Dreamt (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DRINK', 'I', 'When you are thirsty.', 'Drank', 'Example of Drank (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DRIVE', 'I', 'What one does in the car.', 'Drove', 'Example of Drove (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'EAT', 'I', 'Satisfy your hunger.', 'Ate', 'Example of Ate (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FALL', 'I', 'Go down under the force of gravity.', 'Fell', 'Example of Fell (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FEEL', 'I', 'To perceive something by physical contact.', 'Felt', 'Example of Felt (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FIGHT', 'I', 'It is the action of beating someone else.', 'Fought', 'Example of Fought (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FIND', 'I', 'To locate by search or effort.', 'Found', 'Example of Found (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FLY', 'I', 'The birds do this.', 'Flew', 'Example of Flew (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FORGET', 'I', 'When you leave something without realizing.', 'Forgot', 'Example of Forgot (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FORGIVE', 'I', 'To grant pardon for (an offense).', 'Forgave', 'Example of Forgave (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FREEZE', 'I', 'It is a power from subzero.', 'Froze', 'Example of Froze (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'GIVE', 'I', 'When you _____ a present to the birthday boy.', 'Gave', 'Example of Gave (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'GROW', 'I', 'What does a tree do when time passes?', 'Grew', 'Example of Grew (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HEAR', 'I', 'When you listen to something.', 'Heard', 'Example of Heard (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HIT', 'I', 'The boxers do this.', 'Hit', 'Example of Hit (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'KEEP', 'I', 'When you _____ a something in good condition.', 'Kept', 'Example of Kept (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LEARN', 'I', 'When you get new knowledge.', 'Learnt', 'Example of Learnt (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LEND', 'I', 'When he asks you for a pencil you …', 'Lent', 'Example of Lent (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LIE', 'I', 'When you do not say the true.', 'Lay', 'Example of Lay (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'MAKE', 'I', 'When you execute an action.', 'Made', 'Example of Made (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'MEET', 'I', 'When you know new people.', 'Met', 'Example of Met (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'PAY', 'I', 'What you do when you buy something?', 'Paid', 'Example of Paid (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'READ', 'I', 'When you ____ a book.', 'Read', 'Example of Read (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'RIDE', 'I', 'To sit on and manage a horse.', 'Rode', 'Example of Rode (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'RISE', 'I', 'When something is higher than another.', 'Rose', 'Example of Rose (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'RUN', 'I', 'You have to walk fast.', 'Ran', 'Example of Ran (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SEE', 'I', 'You use your eyes to do this.', 'Saw', 'Example of Saw (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SHOW', 'I', 'When you hide something, you don t want it …', 'Showed', 'Example of Showed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SLEEP', 'I', 'You have to close your eyes to ____', 'Slept', 'Example of Slept (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SPEND', 'I', 'When you buy something.', 'Spent', 'Example of Spent (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SWIM', 'I', 'What you do in a pool or the sea.', 'Swam', 'Example of Swam (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'TAKE', 'I', 'To catch or get.', 'Took', 'Example of Took (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'TEACH', 'I', 'When someone helps you to learn something.', 'Taught', 'Example of Taught (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'TEAR', 'I', 'When drops comes out of the eye.', 'Tore', 'Example of Tore (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'THROW', 'I', 'When a person throws something with force.', 'Threw', 'Example of Threw (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'UNDERSTAND', 'I', 'Dogs can _____ indication from their owner.', 'Understood', 'Example of Understood (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'WEAR', 'I', 'When you put clothes.', 'Wore', 'Example of Wore (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'WIN', 'I', 'When you end first.', 'Won', 'Example of Won (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'WRITE', 'I', 'You need a pencil to do this.', 'Wrote', 'Example of Wrote (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ADD', 'R', 'To join so as to bring about an increase.', 'Added', 'Example of Added (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ADVISE', 'R', 'To recommend as wise or sensible.', ' advised', 'Example of  advised (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ANNOY', 'R', 'When you are furious you are.', 'Annoyed', 'Example of Annoyed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ANSWER', 'R', 'Someone asks you something and you have to ...', 'Answered', 'Example of Answered (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ARREST', 'R', 'It is what does the police to the criminals.', 'Arrested', 'Example of Arrested (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ATTACK', 'R', 'It is a word that engages in battles.', 'Attacked', 'Example of Attacked (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BOIL', 'R', 'You put a pod of water to____to make coffe.', 'Boiled', 'Example of Boiled (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BRUSH', 'R', 'You do it to clean your teeth.', 'Brushed', 'Example of Brushed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'BURN', 'R', 'When you leave something in the fire.', 'Burnt', 'Example of Burnt (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CALL', 'R', 'You need a cellphone to do this.', 'Called', 'Example of Called (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CLAP', 'R', 'You use your hands to do this.', 'Clapped', 'Example of Clapped (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CLEAN', 'R', 'When a broom is ____ the house.', 'Cleaned', 'Example of Cleaned (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'COST', 'R', 'To require the payment of money in an exchange.', 'Costed', 'Example of Costed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'CRY', 'R', 'When you get tears from your eyes.', 'Cried', 'Example of Cried (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DANCE', 'R', 'When you move to the rhythm of the music.', 'Danced', 'Example of Danced (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DECIDE', 'R', 'When a person is not sure which to choose.', 'Decided', 'Example of Decided (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'DISAPPEAR', 'R', 'The opposite of appear is …', 'Disappeared', 'Example of Disappeared (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'END', 'R', 'When something concludes.', 'Ended', 'Example of Ended (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ENJOY', 'R', 'When you like something.', 'Enjoyed', 'Example of Enjoyed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'ESCAPE', 'R', 'Its on the top left corner on the keyboard.', 'Escaped', 'Example of Escaped (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'EXIST', 'R', 'It is the opposite of not existing.', 'Existed', 'Example of Existed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FAIL', 'R', 'When you try something but it is not working.', 'Failed', 'Example of Failed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FIX', 'R', 'It is the opposite of destroy.', 'Fixed', 'Example of Fixed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FOLLOW', 'R', 'Go behind another person.', 'Followed', 'Example of Followed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'FRY', 'R', 'You need a pan and oil for this.', 'Fried', 'Example of Fried (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HATE', 'R', 'To dislike intensely.', 'Hated', 'Example of Hated (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HELP', 'R', 'When a person supports one in problems.', 'Helped', 'Example of Helped (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HOPE', 'R', 'I ____ you are good.', 'Hoped', 'Example of Hoped (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'HUG', 'R', 'When you surround someone with arms.', 'Hugged', 'Example of Hugged (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'IMAGINE', 'R', 'When you create something in your mind you.', 'Imagined', 'Example of Imagined (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'INTERRUPT', 'R', 'To stop a person while speaking or working.', 'Interrupted', 'Example of Interrupted (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'JUMP', 'R', 'To move suddenly or quickly.', 'Jumped', 'Example of Jumped (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'KICK', 'R', 'You need a leg to do it.', 'Kicked', 'Example of Kicked (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'KISS', 'R', 'When two mouths are about to …', 'Kissed', 'Example of Kissed (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LISTEN', 'R', 'When you______ an audio.', 'Listened', 'Example of Listened (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LOOK', 'R', 'When a person stays looking at one thing.', 'Looked', 'Example of Looked (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'LOVE', 'R', 'Feeling to someone.', 'Loved', 'Example of Loved (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'MOVE', 'R', 'When you dance you ____ your legs and arms.', 'Moved', 'Example of Moved (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'OPEN', 'R', 'When you ___ the door.', 'Opened', 'Example of Opened (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'PEEL', 'R', 'To strip something of it is skin.', 'Peeled', 'Example of Peeled (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'RAIN', 'R', 'When water falls from the sky.', 'Rained', 'Example of Rained (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SEARCH', 'R', 'When you _____ for something you lost.', 'Searched', 'Example of Searched (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SHARE', 'R', 'The action of give something to someone else.', 'Shared', 'Example of Shared (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SMILE', 'R', 'You use it when you are happy.', 'Smiled', 'Example of Smiled (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'SMOKE', 'R', 'It is white and comes out of a cigarette.', 'Smoked', 'Example of Smoked (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'TOUCH', 'R', 'You can  ... the screen of phone.', 'Touched', 'Example of Touched (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'VISIT', 'R', 'When you  ... your family who live far away.', 'Visited', 'Example of Visited (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'WALK', 'R', 'The action of move your legs slowly.', 'Walked', 'Example of Walked (afirmativo, negativo e interrogativo).', DEFAULT, 1);
INSERT INTO `hangman`.`words` (`id`, `erased`, `word`, `type`, `clue`, `simplepast`, `example`, `timestamp`, `user_id`) VALUES (DEFAULT, 0, 'WORRY', 'R', 'To feel or be uneasy or anxious.', 'Worried', 'Example of Worried (afirmativo, negativo e interrogativo).', DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hangman`.`room`
-- -----------------------------------------------------
START TRANSACTION;
USE `hangman`;
INSERT INTO `hangman`.`room` (`id`, `roomname`, `description`, `lives`, `clue`, `clueafter`, `feedback`, `random`, `isopen`, `timestamp`, `roomcode`, `qrstring`, `user_id`) VALUES (DEFAULT, 'Sala de ejemplo', 'Sala creada para pruebas', 3, 1, 3, 1, 0, 1, DEFAULT, '123456', 'noporelmomento', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hangman`.`room_has_words`
-- -----------------------------------------------------
START TRANSACTION;
USE `hangman`;
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 1, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 3, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 5, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 7, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 9, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 10, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 15, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 20, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 25, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 27, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 29, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 30, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 31, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 33, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 40, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 50, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 60, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 70, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 80, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `hangman`.`room_has_words` (`room_id`, `word_id`, `used`, `guessed`, `typefails`, `pastfails`, `clue`, `example`) VALUES (1, 100, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

COMMIT;

