Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 6 Nov 2016 17:12:11 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog: pcipcwd_show_card_info: wrong format string
Message-ID: <20161106161211.GB7479@spo001.leaseweb.nl>
References: <20161105145028.4894-1-xypron.glpk@gmx.de> <87276aec-7040-798e-fd91-1d0e616db303@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87276aec-7040-798e-fd91-1d0e616db303@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi All,

> On 11/05/2016 07:50 AM, Heinrich Schuchardt wrote:
> >fw_rev_major and fw_rev_minor are defined as int.
> >Use %d to print them.
> >
> >Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >---
> > drivers/watchdog/pcwd_pci.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> >index c0d07ee..e1fbbf6 100644
> >--- a/drivers/watchdog/pcwd_pci.c
> >+++ b/drivers/watchdog/pcwd_pci.c
> >@@ -234,7 +234,7 @@ static void pcipcwd_show_card_info(void)
> > 	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major,
> > 								&fw_rev_minor);
> > 	if (got_fw_rev)
> >-		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
> >+		sprintf(fw_ver_str, "%d.%02d", fw_rev_major, fw_rev_minor);
> > 	else
> > 		sprintf(fw_ver_str, "<card no answer>");
> >
> >
> Hmm ... I don't think that a negative version number makes much sense.
> Turns out inb() returns a char on some architectures, meaning it is signed,
> meaning it _could_ return a negative number if the version number is 128
> or above. I don't want to risk us reporting version number -128.-110 just
> to make compilers happy.

I couldn't have said this better myself :-) version info is indeed to be consider as an unsigned int.

Kind regards,
Wim.
