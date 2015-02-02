Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57845 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854AbbBBXQA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 18:16:00 -0500
Date: Tue, 3 Feb 2015 00:15:51 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Masanari Iida <standby24x7@gmail.com>
Cc: thomas.mingarelli@hp.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: Fix initialization message in hpwdt.c
Message-ID: <20150202231551.GA16749@spo001.leaseweb.nl>
References: <1413977075-8938-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413977075-8938-1-git-send-email-standby24x7@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Masanari,

> allow_kdump was enabled as default since following commit.
> 
> commit a089361cf5f1d6a5295aa5385238bd044998e1e9,
> watchdog: hpwdt: Unregister NMI events on exit.
> 
> But the initialization message was not modified.
> So it still shows
> 
>   HP Watchdog Timer Driver: NMI decoding initialized,
>   allow kernel dump: ON (default = 0/OFF)    <=
> 
> This "default = 0/OFF" message may confuse users.
> Fix it as "default = 1/ON".
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

