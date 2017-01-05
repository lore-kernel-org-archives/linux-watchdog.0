Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.197]:60026 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761846AbdAEL4A (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 5 Jan 2017 06:56:00 -0500
Subject: Re: [PATCH 4/4] watchdog: tangox: Use watchdog core to install
 restart handler
To: Mans Rullgard <mans@mansr.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1483565318-25578-1-git-send-email-linux@roeck-us.net>
 <1483565318-25578-4-git-send-email-linux@roeck-us.net>
 <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com>
 <yw1xmvf5ohx2.fsf@unicorn.mansr.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <aaf896ca-d2f1-1a47-ef21-762db1e62a56@sigmadesigns.com>
Date: Thu, 5 Jan 2017 12:55:45 +0100
MIME-Version: 1.0
In-Reply-To: <yw1xmvf5ohx2.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Language: 
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 05/01/2017 12:38, M=E5ns Rullg=E5rd wrote:

> Marc Gonzalez writes:
>=20
>> Guenter, patch c7ef68c32265 states "Fixes: a3e376d26ace".
>> Is that true? I mean, they seem quite orthogonal; then again I know
>> nothing of this framework.
>=20
> I don't see the relation of either of those to this patch.

There is none. I just happened to git log the file because
of this proposed patch.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
