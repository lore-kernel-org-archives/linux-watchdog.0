Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:35507 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752377AbcGRTjI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jul 2016 15:39:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 9962E290E55
	for <linux-watchdog@vger.kernel.org>; Mon, 18 Jul 2016 19:32:39 +0000 (UTC)
Message-ID: <1468870350.1900.18.camel@perches.com>
Subject: Re: [PATCH v3] Documentation: Move samples from doc to samples/
From: Joe Perches <joe@perches.com>
To: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>, corbet@lwn.net,
	sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, timur@codeaurora.org,
	arnd@arndb.de, nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org
Date: Mon, 18 Jul 2016 12:32:30 -0700
In-Reply-To: <1468870066-11792-1-git-send-email-maheshkhanwalkar@gmail.com>
References: <578D2264.6060205 () codeaurora ! org>
	 <1468870066-11792-1-git-send-email-maheshkhanwalkar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2016-07-18 at 15:27 -0400, Mahesh Khanwalkar wrote:
> Moved sample code found in Documentation/ to samples/ but kept actual
> documentation where it is, while updating any in-text references to the
> moved code. Updated the Documentation/Makefile and samples/Makefile to
> reflect the change. Built with CONFIG_SAMPLES=y in .config with no
> build errors. The directories added within samples/ still follow the
> same structure that they did in Documentation. Directories in
> Documentation/ that contained code still exist, only the code within
> them has been moved out accordingly.

The MAINTAINERS file should also have file patterns updated.

