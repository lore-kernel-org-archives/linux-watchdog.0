Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:42624 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdDCH7X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 03:59:23 -0400
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
To: Paul Menzel <paulepanter@users.sourceforge.net>,
        Guenter Roeck <linux@roeck-us.net>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
 <20170331150524.GA31555@roeck-us.net>
 <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
 <1491201299.2321.42.camel@users.sourceforge.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Tim Small <tim@seoss.co.uk>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Brandon <tbrandonau@gmail.com>,
        Eddi De Pieri <eddi@depieri.net>,
        linux-kernel@vger.kernel.org
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <b42d979b-9172-48ba-dba9-a67d9a143bca@pr.hu>
Date: Mon, 3 Apr 2017 09:59:06 +0200
MIME-Version: 1.0
In-Reply-To: <1491201299.2321.42.camel@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

2017-04-03 08:34 keltez=C3=A9ssel, Paul Menzel =C3=ADrta:
> Dear Zolt=C3=A1n,
>
>
> Am Samstag, den 01.04.2017, 12:13 +0200 schrieb Boszormenyi Zoltan:
>
> [=E2=80=A6]
>
>> and have split the patch into three pieces now (USB quirks, i2c-piix4
>> and sp5100_tco) and they were sent to the relevant mailing lists.
>
> Could you please add me to the receiver list of these patches, so that
> I can test them? Maybe also Christian (the commit author introducing
> the regression), Tim (bug reporter), and Nehal from AMD?
>
> If you uploaded them to the Kernel.org Bugtracker, that=E2=80=99d also =
work for
> me.

did both.

Best regards,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

>
>
> Thanks,
>
> Paul
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
