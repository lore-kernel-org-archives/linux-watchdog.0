Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:8172
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757133Ab2HGCUO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Aug 2012 22:20:14 -0400
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
CC: "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [v2 PATCH 1/1] booke/wdt: some ioctls do not return values
 properly
Date: Tue, 7 Aug 2012 02:20:10 +0000
Message-ID: <CAOZdJXXViXtto5mFQwPxK7Z5DnTMRYxeViQvW4xmvgn-fapZHg@mail.gmail.com>
References: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
Content-Language: en-US
Content-Type: text/plain; charset=US-ASCII
Content-ID: <6B53B4F96592F74595D0D0B723FBA696@mgd.freescale.com>
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 6, 2012 at 8:59 PM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
> Fix some booke wdt ioctls return value error.
>
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

It's not the greatest patch description, but it'll do.

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
