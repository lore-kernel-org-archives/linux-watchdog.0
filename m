Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33303 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbHTTy6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Aug 2015 15:54:58 -0400
Received: by lalv9 with SMTP id v9so29170428lal.0
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2015 12:54:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BD1550.708@roeck-us.net>
References: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1438454237-22043-2-git-send-email-ariel@vanguardiasur.com.ar>
	<55BD1550.708@roeck-us.net>
Date: Thu, 20 Aug 2015 16:54:57 -0300
Message-ID: <CAAEAJfB2aHpaoQpZWCrnhajNjQRCu6zWfFkyZ=Ad9hPnnVx0gw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Joachim Eastwood <manabian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 1 August 2015 at 15:52, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/01/2015 11:37 AM, Ariel D'Alessandro wrote:
>>
>> This commit adds support for the watchdog timer found in NXP LPC SoCs
>> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
>> share the same watchdog hardware.
>>
>> Watchdog driver registers a restart handler that will restart the syst=
em
>> by performing an incorrect feed after ensuring the watchdog is enabled=
 in
>> reset mode.
>>
>> As watchdog cannot be disabled in hardware, driver's stop routine will
>> regularly send a keepalive ping using a timer.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Wim,

Any chances you pick this in time for the next merge window?

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
