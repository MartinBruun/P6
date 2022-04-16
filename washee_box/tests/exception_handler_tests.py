import pytest
import pytz

from datetime import datetime

from washee_box.exception_handling.exception_handler import ExceptionHandler


def test_exception_handler_can_be_initialized():
    # Arrange
    # Act
    handler = ExceptionHandler()
    # Assert
    assert True


def test_exception_handler_can_write_exception_to_a_log():
    # Arrange
    eh = ExceptionHandler()
    eh.reset_log()

    # Act
    try:
        raise Exception("Some Exception")
    except Exception as exc:
        eh.handle(exc, log=True)

    # Assert
    with open(eh.log_location, "r+") as f:
        line = f.readlines()
        assert "Some Exception" in line
    eh.reset_log()


def test_exception_handler_can_fail_silently_and_show_to_console(capsys):
    # Arrange
    eh = ExceptionHandler()

    # Act
    try:
        raise Exception("Some Exception")
    except Exception as exc:
        eh.handle(exc, show=True)

    # Assert
    captured = capsys.readouterr()
    assert "Some Exception" in captured.out


def test_exception_handler_can_fail_and_crash_the_program():
    # Arrange
    eh = ExceptionHandler()

    # Act
    try:
        raise Exception("Some Exception")
    except Exception as exc:
        with pytest.raises(Exception) as eh_info:
            eh.handle(exc)
        # Assert
        assert "Some Exception" in str(eh_info.value)


def test_exception_handler_should_crash_and_warn_if_no_option_has_been_given():
    # Arrange
    eh = ExceptionHandler()

    # Act
    try:
        raise Exception("Some Exception")
    except Exception as exc:
        with pytest.raises(Exception) as eh_info:
            eh.handle(exc)
        # Assert
        assert "Some Exception" in str(eh_info.value)


def test_exception_handlers_log_is_timestamped():
    # Arrange
    eh = ExceptionHandler()
    eh.reset_log()

    # Act
    try:
        raise Exception("Some Exception")
    except Exception as exc:
        eh.handle(exc, log=True)

    # Assert
    with open(eh.log_location, "r+") as f:
        lines_list = f.readlines()
        lines_str = "\n".join(lines_list)
        assert str(datetime.now(pytz.timezone('Europe/Copenhagen')).strftime("%Y/%m/%d, %H:%M")) in lines_str
    eh.reset_log()
