Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:63237 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754891AbbBDLE4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Feb 2015 06:04:56 -0500
Message-ID: <1423047893.23022.13.camel@x220>
Subject: Re: watchdog: SOC_MT7621?
From: Paul Bolle <pebolle@tiscali.nl>
To: John Crispin <blogic@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Ralf Baechle <ralf@linux-mips.org>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2015 12:04:53 +0100
In-Reply-To: <54D1F248.4090406@openwrt.org>
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2015-02-04 at 11:19 +0100, John Crispin wrote:
> On 04/02/2015 11:13, Paul Bolle wrote:
> > Is SOC_MT7621 still being worked on?
> 
> yes we dropped the series as it collided with the gic rework that
> chromiun.org was working on. i hope to push it during the next merge
> window. the 1004k support has just been flaky till now as there was
> never any real silicon to test it on. the chromium people really did a
> good job at making the gic code nicer.

Thanks for explaining this. Unless SOC_MT7621 takes a long time to land
in linux-next I won't be bothering you again about this. (I think I'll
use "by the end of the v3.20 series" as a definition of a long time.)

> quite an impressive Cc list you have there

Yes, that's the way it works with problems that span two (or more)
subsystems (in this case watchdog and MIPS). Actually, much longer CC
lists are used regularly on lkml.

Thanks!


Paul Bolle

