Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57468 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab3HBVBg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Aug 2013 17:01:36 -0400
Message-ID: <51FC1E2F.6020308@roeck-us.net>
Date: Fri, 02 Aug 2013 14:01:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bruno_Andr=E9_Ferreira?= <bruno.ferreira@efacec.com>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Giel van Schijndel <me@mortis.eu>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: Fintek F81865 chip (Wdog support)
References: <51409586.4030204@efacec.com> <07936d3ec21c2de67a97b2664c7bf484@mortis.eu> <20130526164410.GA8274@spo001.leaseweb.com>,<51FBBF84.2050109@efacec.com> <D9EA4899424AAF4E89868AB4BB0DCD82879596A5@S103.efacec.pt>
In-Reply-To: <D9EA4899424AAF4E89868AB4BB0DCD82879596A5@S103.efacec.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 08/02/2013 07:48 AM, Bruno Andr=E9 Ferreira wrote:
> Sorry.
>
> Wrong driver...
>
> Best regards,
> Bruno Ferreira
> ________________________________________
> From: BrunoFerreira [bruno.ferreira@efacec.com]
> Sent: Friday, August 02, 2013 3:17 PM
> To: Wim Van Sebroeck
> Cc: Giel van Schijndel; linux-watchdog@vger.kernel.org
> Subject: Re: Fintek F81865 chip (Wdog support)
>
> Hi All.
>
> Sorry about the delay.
> Please find in attach the driver source code with support for this chip=
.
>
Hi Bruno,

Just wondering ... why didn't you just add the new chip type to the exist=
ing f71808e driver ?

I don't see a significant enough difference to warrant a new driver. Your=
 driver doesn't
support minutes mode, but I am quite sure that is not a chip limitation. =
Other than that,
everything seems to be identical.

Thanks,
Guenter


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
