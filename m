Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34100 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbE0Mi6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 May 2015 08:38:58 -0400
Received: by wicmc15 with SMTP id mc15so92407248wic.1
        for <linux-watchdog@vger.kernel.org>; Wed, 27 May 2015 05:38:57 -0700 (PDT)
Message-ID: <5565BAE1.1000704@linaro.org>
Date: Wed, 27 May 2015 14:38:57 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
CC: kernel@stlinux.com
Subject: Re: [PATCH v2.1 02/12] clocksource: sti: Provide support for the
 ST LPC Clocksource IP
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org> <1431435500-22899-3-git-send-email-lee.jones@linaro.org> <20150526123943.GI11677@x1>
In-Reply-To: <20150526123943.GI11677@x1>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2015 02:39 PM, Lee Jones wrote:
> clocksource: sti: Provide support for the ST LPC Clocksource IP
>
> This IP is shared with Watchdog and RTC functionality.  All 3 of
> these devices are mutually exclusive from one another i.e. Only 1
> IP can be used at any given time.  We use the device-driver model
> combined with a DT 'mode' property to enforce this.
>
> The ST LPC Clocksource IP can be used as the system (tick) timer.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me.

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
