from libqtile.config import Group

groups = [Group(i) for i in '123456789']
groups.append(Group('0', layout='bsp'))
