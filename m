Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34982 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbcHDA2Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2016 20:28:24 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so82106991pfd.2
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Aug 2016 17:27:35 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
	<1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
	<578271D3.4080704@roeck-us.net> <7hbn237aw7.fsf@baylibre.com>
Date: Wed, 03 Aug 2016 17:27:32 -0700
In-Reply-To: <7hbn237aw7.fsf@baylibre.com> (Kevin Hilman's message of "Mon, 11
	Jul 2016 21:12:08 -0700")
Message-ID: <m2bn19qsy3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Kevin Hilman <khilman@baylibre.com> writes:

> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Would this go in through one of the arm trees ?
>
> You can take the driver through the watchdog tree, but I'll take the DT
> stuff through the amlogic tree (and submit via arm-soc).  
>
> However, with your ack, and since this is a brand new driver, I could
> take the driver as well.  Just let me know your preference.

ping... do you have a prefernce here?

Thanks,

Kevin
