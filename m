Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:54338 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755515AbcKESU2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 5 Nov 2016 14:20:28 -0400
Subject: Re: [PATCH 1/1] watchdog: pcipcwd_show_card_info: wrong format string
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
References: <20161105145028.4894-1-xypron.glpk@gmx.de>
 <87276aec-7040-798e-fd91-1d0e616db303@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <041ea1cf-f0ef-febf-4ae2-c00f615d6bf1@gmx.de>
Date: Sat, 5 Nov 2016 19:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <87276aec-7040-798e-fd91-1d0e616db303@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 11/05/2016 04:29 PM, Guenter Roeck wrote:
> On 11/05/2016 07:50 AM, Heinrich Schuchardt wrote:
>> fw_rev_major and fw_rev_minor are defined as int.
>> Use %d to print them.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  drivers/watchdog/pcwd_pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
>> index c0d07ee..e1fbbf6 100644
>> --- a/drivers/watchdog/pcwd_pci.c
>> +++ b/drivers/watchdog/pcwd_pci.c
>> @@ -234,7 +234,7 @@ static void pcipcwd_show_card_info(void)
>>      got_fw_rev =3D send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_maj=
or,
>>                                  &fw_rev_minor);
>>      if (got_fw_rev)
>> -        sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
>> +        sprintf(fw_ver_str, "%d.%02d", fw_rev_major, fw_rev_minor);
>>      else
>>          sprintf(fw_ver_str, "<card no answer>");
>>
>>
> Hmm ... I don't think that a negative version number makes much sense.
> Turns out inb() returns a char on some architectures, meaning it is sig=
ned,
> meaning it _could_ return a negative number if the version number is 12=
8
> or above. I don't want to risk us reporting version number -128.-110 ju=
st
> to make compilers happy.

send_command uses inb_p to read single bytes.

The signature of inb_p is
u8 inb_p(unsigned long addr)

So fw_rev_major and fw_rev_minor should always be
in the range of 0..255.

Regards

Heinrich
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
