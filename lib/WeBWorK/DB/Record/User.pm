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

package WeBWorK::DB::Record::User;
use base WeBWorK::DB::Record;

=head1 NAME

WeBWorK::DB::Record::User - represent a record from the user table.

=cut

use strict;
use warnings;

BEGIN {
	__PACKAGE__->_fields(
		user_id        => { type => "VARCHAR(100) NOT NULL", key => 1 },
		first_name     => { type => "TEXT" },
		last_name      => { type => "TEXT" },
		email_address  => { type => "TEXT" },
		student_id     => { type => "TEXT" },
		status         => { type => "TEXT" },
		section        => { type => "TEXT" },
		recitation     => { type => "TEXT" },
		comment        => { type => "TEXT" },
		displayMode    => { type => "TEXT" },
		showOldAnswers => { type => "INT" },
		useMathView    => { type => "INT" },
		useMathQuill   => { type => "INT" },
		lis_source_did => { type => "TEXT" },
	);
}

sub full_name {
	my ($self) = @_;

	my $first = $self->first_name;
	my $last  = $self->last_name;

	if (defined $first and $first ne "" and defined $last and $last ne "") {
		return "$first $last";
	} elsif (defined $first and $first ne "") {
		return $first;
	} elsif (defined $last and $last ne "") {
		return $last;
	} else {
		return "";
	}
}

# Do not base64 encode the names in the address.
# Email::Stuffer will do that if needed for a name when it sends the email.
sub rfc822_mailbox {
	my ($self) = @_;

	my $full_name = $self->full_name;
	my $address   = $self->email_address;

	if (defined $address and $address ne "") {
		if (defined $full_name and $full_name ne "") {
			return "$full_name <$address>";
		} else {
			return $address;
		}
	} else {
		return "";
	}
}

1;
