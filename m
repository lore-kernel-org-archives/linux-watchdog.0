Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:59508 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbaBKAGq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Feb 2014 19:06:46 -0500
Received: by mail-we0-f170.google.com with SMTP id w62so4896577wes.15
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Feb 2014 16:06:45 -0800 (PST)
Message-ID: <52F96993.9090007@linaro.org>
Date: Tue, 11 Feb 2014 01:06:43 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 01/19] clocksource: orion: Use atomic access for shared
 registers
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com> <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/06/2014 06:20 PM, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The patch looks good for me.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
