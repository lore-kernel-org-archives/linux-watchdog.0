Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:37326 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3F0Gbl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Jun 2013 02:31:41 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so387472oag.13
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Jun 2013 23:31:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201306262005.05765.heiko@sntech.de>
References: <201306262003.13256.heiko@sntech.de>
	<201306262005.05765.heiko@sntech.de>
Date: Thu, 27 Jun 2013 12:01:40 +0530
Message-ID: <CAK9yfHzY5uPLmGVjHYGPbqR3_YKdMXCwkcOgowURRdf+8uPwtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: dw_wdt: add a devicetree binding
From: Sachin Kamat <sachin.kamat@linaro.org>
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jamie Iles <jamie@jamieiles.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 26 June 2013 23:35, Heiko St=FCbner <heiko@sntech.de> wrote:
> The dw_wdt does not use any platform-specific data, so no new propertie=
s
> need to be introduced. The dw-apb-wdt naming follows other designware
> components in the kernel and is also written like this in documentation
> describing the component.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/watchdog/snps-dw-apb-wdt.txt |   18 ++++++++++=
++++++++
>  drivers/watchdog/dw_wdt.c                            |   10 ++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/snps-dw-=
apb-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/snps-dw-apb-wdt=
.txt b/Documentation/devicetree/bindings/watchdog/snps-dw-apb-wdt.txt
> new file mode 100644
> index 0000000..c20cdd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/snps-dw-apb-wdt.txt
> @@ -0,0 +1,18 @@
> +* Synosis DesignWare APB Watchdog

Probably should be Synopsis?


--=20
With warm regards,
Sachin
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
