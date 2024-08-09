################################################################################
# WeBWorK Online Homework Delivery System
# Copyright &copy; 2000-2023 The WeBWorK Project, https://github.com/openwebwork
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of either: (a) the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any later
# version, or (b) the "Artistic License" which comes with this package.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See either the GNU General Public License or the
# Artistic License for more details.
################################################################################

package WeBWorK::AchievementItems::Surprise;
use Mojo::Base 'WeBWorK::AchievementItems', -signatures;

# Item to print a suprise message

use WeBWorK::Utils qw(x);

sub new ($class) {
	return bless {
		id          => 'Surprise',
		name        => x('Mysterious Package (with Ribbons)'),
		description => x('What could be inside?')
	}, $class;
}

sub print_form ($self, $sets, $setProblemCount, $c) {
	# The form opens the file "suprise_message.txt" in the achievements
	# folder and prints the contents of the file.

	open my $MESSAGE, '<', "$c->{ce}{courseDirs}{achievements}/surprise_message.txt"
		or return $c->tag('p', $c->maketext(q{I couldn't find the file [ACHIEVEMENT_DIR]/surprise_message.txt!}));
	local $/ = undef;
	my $message = <$MESSAGE>;
	close $MESSAGE;

	return $c->tag('div', $c->b($message));
}

sub use_item ($self, $userName, $c) {
	# This doesn't do anything.
}

1;
