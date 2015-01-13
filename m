Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46800 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbAMMYK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Jan 2015 07:24:10 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YB0W2-0021Xo-IO
	for linux-watchdog@vger.kernel.org; Tue, 13 Jan 2015 12:24:10 +0000
Date: Tue, 13 Jan 2015 04:24:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Masanari Iida <standby24x7@gmail.com>
Cc: wim@iguana.be, thomas.mingarelli@hp.com,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: watchdog: hpwdt: Fix initialization message in hpwdt.c
Message-ID: <20150113122401.GA2133@roeck-us.net>
References: <1413977075-8938-1-git-send-email-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413977075-8938-1-git-send-email-standby24x7@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 22, 2014 at 08:24:35PM +0900, Masanari Iida wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
