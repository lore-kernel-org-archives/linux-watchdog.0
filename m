Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:22822 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753158Ab1G0TkA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Jul 2011 15:40:00 -0400
Date: Wed, 27 Jul 2011 21:39:58 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: linux-next: Tree for July 27 (watchdog/hpwdt)
Message-ID: <20110727193958.GA4227@infomag.iguana.be>
References: <20110727141151.d31e3da6a8d21a255473293c@canb.auug.org.au> <20110727094112.89ab9901.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110727094112.89ab9901.rdunlap@xenotime.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Randy,

> > Just in case anyone needs reminding:  Please do not add anything destined
> > for v3.2 into linux-next included trees until after v3.1-rc1.

This is still v3.1 stuff. It basically adds an extra SMBIOS lookup (dmi_walk) to see
if there is a new iLO system.

> When CONFIG_HPWDT_NMI_DECODING is not enabled:
> 
> drivers/watchdog/hpwdt.c:833: error: 'allow_kdump' undeclared (first use in this function)
> drivers/watchdog/hpwdt.c:833: error: 'priority' undeclared (first use in this function)

I fixed the patch. (The last 2 parts of the diff should not have been there...)

Kind regards,
Wim.

