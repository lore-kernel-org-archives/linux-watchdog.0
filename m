Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:41420 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcGSWf2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 18:35:28 -0400
Date: Tue, 19 Jul 2016 16:35:25 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, timur@codeaurora.org,
	arnd@arndb.de, nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: Move samples from doc to samples/
Message-ID: <20160719163525.05af24af@lwn.net>
In-Reply-To: <1468871700-12889-1-git-send-email-maheshkhanwalkar@gmail.com>
References: <1468870350.1900.18.camel () perches ! com>
	<1468871700-12889-1-git-send-email-maheshkhanwalkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Jul 2016 15:55:00 -0400
Mahesh Khanwalkar <maheshkhanwalkar@gmail.com> wrote:

> Moved sample code found in Documentation/ to samples/ but kept actual
> documentation where it is, while updating any in-text references to the
> moved code. Updated the Documentation/Makefile and samples/Makefile to
> reflect the change. Built with CONFIG_SAMPLES=3Dy in .config with no
> build errors. The directories added within samples/ still follow the
> same structure that they did in Documentation. Directories in
> Documentation/ that contained code still exist, only the code within
> them has been moved out accordingly.

So, while I'm generally in favor of moving this code over to samples/,
I'm a bit nervous about a single, do-it-all patch.  I'd rather see each
subsystem's stuff moved separately, with (1) review from the appropriate
maintainer, and (2) some sense that somebody has looked at this code and
ensured that it still makes sense to keep around.

For example, pcmcia/crc32hash.c predates the git era and has only seen
trivial changes in living memory.  I have this vague sense that the
number of new PCMCIA cards needing addition is pretty small these days.
Rather than move it to samples/ (what is it a sample of?), we might want
to consider just getting rid of it.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
