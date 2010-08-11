Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:29253 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815Ab0HKMtN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Aug 2010 08:49:13 -0400
Date: Wed, 11 Aug 2010 14:49:11 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: linux-kernel@vger.kernel.org,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: Re: [PATCH 00/15] hpwdt: make NMI code a config option (+ other
	cleanup)
Message-ID: <20100811124911.GH4288@infomag.iguana.be>
References: <1280274663-9160-1-git-send-email-dannf@hp.com> <20100805214102.GA4288@infomag.iguana.be> <20100806212648.GA30843@infomag.iguana.be> <20100806212933.GA10779@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100806212933.GA10779@ldl.fc.hp.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dan,

> > watchdog: hpwdt (10/12): Construct status message w/ kasprintf and emit it with dev_info
> > watchdog: hpwdt (11/12): Use "decoding" instead of "sourcing"
> > watchdog: hpwdt (12/12): Make NMI decoding a compile-time option
> > 
> > (patch 12 can still be improved).
> 
> Thanks! I'll work on the #ifdef'ing & get you a new #12

I did some changes in the last 3 patches:
I removed patch 10, made patch 11 patch 10 and added and extra patch that moves the nmi decoding init and exit functions in seperate modules.
I'll sent you the 3 new patches. Just let me know if they are OK.

Kind regards,
Wim.

