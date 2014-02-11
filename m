Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:49468 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaBKJLi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 04:11:38 -0500
Received: by mail-wi0-f182.google.com with SMTP id f8so3866590wiw.15
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 01:11:37 -0800 (PST)
Message-ID: <52F9E947.5020004@linaro.org>
Date: Tue, 11 Feb 2014 10:11:35 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 01/19] clocksource: orion: Use atomic access for shared
 registers
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com> <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com> <52F96993.9090007@linaro.org> <20140211083024.GA3687@localhost>
In-Reply-To: <20140211083024.GA3687@localhost>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/11/2014 09:30 AM, Ezequiel Garcia wrote:
> On Tue, Feb 11, 2014 at 01:06:43AM +0100, Daniel Lezcano wrote:
>> On 02/06/2014 06:20 PM, Ezequiel Garcia wrote:
>>> Replace the driver-specific thread-safe shared register API
>>> by the recently introduced atomic_io_clear_set().
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Tested-by: Willy Tarreau <w@1wt.eu>
>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>
>> The patch looks good for me.
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>
> Daniel,
>
> Jason acked this patch for you to take it. Or do you prefer that we
> merge it with the rest of the watchdog series?

I can pick it, but doesn't the watchdog series depend on it ?

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
