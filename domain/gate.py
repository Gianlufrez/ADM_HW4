"""A module for a gate in the algorithmic question of HW4 for Algorithmic Methods for Data Science."""


class Gate:
    """A university gate through which students can enter and which is supervised by a guard."""

    def __init__(self, number):
        """Constructor for the Gate class.
	
        :arg
        number (int) - the number of this gate.

        Returns a new instance of the Gate class.
        """
        self.number = number
        self.closed = False
        self.students = []
        self.priority = 10 ** 3 + 1  # 10**3 is the max number of students possible, so this gate will be last
        self.guard = None

    def close(self):
        """Closes this gate such that no more students can enter."""
        self.closed = True

    def set_guard(self, guard):
        """Sets the guard for this gate.

        :arg
        guard - the guard to be assigned to this gate.
        """
        self.guard = guard

    def has_guard(self):
        """Returns whether this gate has a guard assigned."""
        return self.guard is not None

    def remove_guard(self):
        """Removes and returns the guard of this gate.

        :returns
        the guard that was supervising this gate. Will return None if no guard was set.
        """
        guard = self.guard
        self.guard = None
        self.close()

        return guard

    def add_student(self, student):
        """Adds a student into the end of the queue and sets the priority of this gate.

        :arg
        student - the student to be placed at the end of the queue.
        """
        self.students.append(student)
        self._set_priority()

    def let_student_in(self):
        """Lets in a student and sets the priority of this gate if this gate has a guard.

        :raises
        RuntimeError if there is no guard present or the gate is closed.
        """
        if self.closed:
            raise RuntimeError('The gate is closed, no more students can be let in.')
        if self.guard is None:
            raise RuntimeError(f'There is no guard set on {self}.')

        self.students.pop(0)
        self._set_priority()

    def can_be_closed(self):
        """Returns whether this gate can be closed.

        A gate can be closed when there are no more students waiting to be let in.

        :returns
        True if there are no more students waiting to be let in. Otherwise, False.
        """
        return len(self.students) == 0

    def _set_priority(self):
        if self.students:
            self.priority = self.students[0]
        else:
            self.priority = 10 ** 3 + 1

    def __lt__(self, other):
        """Compares the priority of each gate."""
        return self.priority < other.priority

    def __repr__(self):
        return f'Gate; {self.number}. Closed; {self.closed}. Students waiting; {self.students}. Guard; {self.guard}.'
