Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46871 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbETBLD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 21:11:03 -0400
Message-ID: <555BDF22.2090208@roeck-us.net>
Date: Tue, 19 May 2015 18:10:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 01/10] watchdog: Rename watchdog_active to watchdog_hw_active
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
> Before extending the watchdog core midlayer, it is useful to rename
> the watchdog_active function so that it states explicitly what it
> really does. That is, "active" watchdog means really that the watchdog
> hardware is running and needs pinging to prevent a watchdog reset
> taking place in near future.
>
> This is different to "watchdog open" state, which simply states that
> kernel is expecting the user space to keep the watchdog alive. These
> states might become different mainly because some hardware have
> limitations that prevent them from being stopped at will.
>

I don't see why this is needed. If you need another state, per your
description, it would be "open" in addition to "active".

Guenter

