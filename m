Return-path: <khilman@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,  Wim Van Sebroeck <wim@iguana.be>,  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,  linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
	<1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
	<578271D3.4080704@roeck-us.net>
Date: Mon, 11 Jul 2016 21:12:08 -0700
In-Reply-To: <578271D3.4080704@roeck-us.net> (Guenter Roeck's message of "Sun,
	10 Jul 2016 09:03:31 -0700")
Message-ID: <7hbn237aw7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck <linux@roeck-us.net> writes:

> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Would this go in through one of the arm trees ?

You can take the driver through the watchdog tree, but I'll take the DT
stuff through the amlogic tree (and submit via arm-soc).  

However, with your ack, and since this is a brand new driver, I could
take the driver as well.  Just let me know your preference.

Thanks,

Kevin
