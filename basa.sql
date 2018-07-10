SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `base`
--
CREATE DATABASE IF NOT EXISTS `base` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `base`;

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `setLogs` (IN `myResult` VARCHAR(255), IN `myTime` VARCHAR(255))  NO SQL
BEGIN
set @baseId := 0;

select id into @baseId from self WHERE desition = myResult;

INSERT INTO logs_db(id, time, result) VALUES(@baseId, myTime, myResult);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUr` (IN `InputUr` VARCHAR(255), IN `InputRes` VARCHAR(255))  NO SQL
INSERT INTO self(equation, desition) VALUES(InputUr, InputRes)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `logs_db`
--

CREATE TABLE `logs_db` (
  `result` varchar(255) NOT NULL,
  `time` varchar(128) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `self`
--

CREATE TABLE `self` (
  `equation` varchar(128) NOT NULL,
  `desition` varchar(255) NOT NULL,
  `id` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `logs_db`
--
ALTER TABLE `logs_db`
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `self`
--
ALTER TABLE `self`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equation` (`equation`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `self`
--
ALTER TABLE `self`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `logs_db`
--
ALTER TABLE `logs_db`
  ADD CONSTRAINT `logs_db_ibfk_1` FOREIGN KEY (`id`) REFERENCES `self` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
