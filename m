Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148]:55100 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334Ab3EaJCG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 May 2013 05:02:06 -0400
Date: Fri, 31 May 2013 11:04:07 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] watchdog: New watchdog driver for MEN A21
 watchdogs
Message-ID: <20130531090406.GA7256@jtlinux>
References: <20130531085842.GA8572@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130531085842.GA8572@jtlinux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 31, 2013 at 10:58:48AM +0200, Johannes Thumshirn wrote:
> This patch adds the driver for the watchdog devices found on MEN Mikro
> Elektronik A21 VMEbus CPU Carrier Boards. It has DT-support and uses the
> watchdog framework.
[...]
> +MODULE_DESCRIPTION("MEN A21 Watchdog");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:a21-watchdog");
> --
> 1.7.9.5
>


Args, sorry messed up the thread :-(.

I'm not so firm with using mutt for patches, but git send-email doesn't seem
to like Exchange here...


Johannes
