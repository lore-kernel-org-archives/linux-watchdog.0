Return-path: <carlo.caione@gmail.com>
MIME-Version: 1.0
Sender: carlo.caione@gmail.com
In-Reply-To: <5640B5BF.9040909@roeck-us.net>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
	<1446985137-25498-2-git-send-email-carlo@caione.org>
	<5640B5BF.9040909@roeck-us.net>
Date: Wed, 11 Nov 2015 09:54:04 +0100
Message-ID: <CAOQ7t2bmNNTPxgZy4uZQF_u4yH2nxfMR_FqpKM0GavoUS9rRkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] watchdog: meson: Enable meson SoC specific data
From: Carlo Caione <carlo@caione.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, Daniel Drake <drake@endlessm.com>,
	Jerry Cao <jerry.cao@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
	Romain Perier <romain.perier@gmail.com>, Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 9, 2015 at 4:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/08/2015 04:18 AM, Carlo Caione wrote:
>>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> With this patch we refactor the driver code to enable watchdog support
>> for all platforms based on Amlogic meson SoCs.
>> The new default timeout is also now chosen considering the maximum
>> timeout allowed by the SoC.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Wim,
any (N)ACK on this?

-- 
Carlo Caione
