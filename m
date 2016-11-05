Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35486 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbcKEP30 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 5 Nov 2016 11:29:26 -0400
Subject: Re: [PATCH 1/1] watchdog: pcipcwd_show_card_info: wrong format string
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Wim Van Sebroeck <wim@iguana.be>
References: <20161105145028.4894-1-xypron.glpk@gmx.de>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <87276aec-7040-798e-fd91-1d0e616db303@roeck-us.net>
Date: Sat, 5 Nov 2016 08:29:09 -0700
MIME-Version: 1.0
In-Reply-To: <20161105145028.4894-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/05/2016 07:50 AM, Heinrich Schuchardt wrote:
> fw_rev_major and fw_rev_minor are defined as int.
> Use %d to print them.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/watchdog/pcwd_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> index c0d07ee..e1fbbf6 100644
> --- a/drivers/watchdog/pcwd_pci.c
> +++ b/drivers/watchdog/pcwd_pci.c
> @@ -234,7 +234,7 @@ static void pcipcwd_show_card_info(void)
>  	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major,
>  								&fw_rev_minor);
>  	if (got_fw_rev)
> -		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
> +		sprintf(fw_ver_str, "%d.%02d", fw_rev_major, fw_rev_minor);
>  	else
>  		sprintf(fw_ver_str, "<card no answer>");
>
>
Hmm ... I don't think that a negative version number makes much sense.
Turns out inb() returns a char on some architectures, meaning it is signed,
meaning it _could_ return a negative number if the version number is 128
or above. I don't want to risk us reporting version number -128.-110 just
to make compilers happy.

Guenter

