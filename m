Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54657 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbcGSWqU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 18:46:20 -0400
Subject: Re: [PATCH v4] Documentation: Move samples from doc to samples/
To: Jonathan Corbet <corbet@lwn.net>,
	Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
References: <1468870350.1900.18.camel () perches ! com>
 <1468871700-12889-1-git-send-email-maheshkhanwalkar@gmail.com>
 <20160719163525.05af24af@lwn.net>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, timur@codeaurora.org,
	arnd@arndb.de, nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	linux-watchdog@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc9c89f8-0f8d-a31e-ac62-acedc6bd4326@infradead.org>
Date: Tue, 19 Jul 2016 15:46:09 -0700
MIME-Version: 1.0
In-Reply-To: <20160719163525.05af24af@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/19/16 15:35, Jonathan Corbet wrote:
> On Mon, 18 Jul 2016 15:55:00 -0400
> Mahesh Khanwalkar <maheshkhanwalkar@gmail.com> wrote:
> 
>> Moved sample code found in Documentation/ to samples/ but kept actual
>> documentation where it is, while updating any in-text references to the
>> moved code. Updated the Documentation/Makefile and samples/Makefile to
>> reflect the change. Built with CONFIG_SAMPLES=y in .config with no
>> build errors. The directories added within samples/ still follow the
>> same structure that they did in Documentation. Directories in
>> Documentation/ that contained code still exist, only the code within
>> them has been moved out accordingly.
> 
> So, while I'm generally in favor of moving this code over to samples/,

ack that.

> I'm a bit nervous about a single, do-it-all patch.  I'd rather see each
> subsystem's stuff moved separately, with (1) review from the appropriate
> maintainer, and (2) some sense that somebody has looked at this code and
> ensured that it still makes sense to keep around.
> 
> For example, pcmcia/crc32hash.c predates the git era and has only seen
> trivial changes in living memory.  I have this vague sense that the
> number of new PCMCIA cards needing addition is pretty small these days.
> Rather than move it to samples/ (what is it a sample of?), we might want
> to consider just getting rid of it.

That one is not really a sample, it's more of a development/developer tool,
so it should end up in tools/ IMO.


-- 
~Randy
