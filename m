Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33756 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbbKXPDT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 10:03:19 -0500
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
 <20151124071628.GF19888@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56547C31.3070901@roeck-us.net>
Date: Tue, 24 Nov 2015 07:03:13 -0800
MIME-Version: 1.0
In-Reply-To: <20151124071628.GF19888@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 11:16 PM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Sun, Nov 22, 2015 at 07:20:58PM -0800, Guenter Roeck wrote:
>> Introduce an optional hardware maximum timeout in the watchdog core.
>> The hardware maximum timeout can be lower than the maximum timeout.
>>
>> Drivers can set the maximum hardware timeout value in the watchdog data
>> structure. If the configured timeout exceeds the maximum hardware timeout,
>> the watchdog core enables a timer function to assist sending keepalive
>> requests to the watchdog driver.
>>
>> Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>

Hi Uwe,

thanks a lot for the Ack. I have v6 in the works, which changes recording
of last_keepalive when the watchdog is started. Does your Ack include that
change, or do you prefer to have another look ?

Thanks,
Guenter

