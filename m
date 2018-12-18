Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36257 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRHsU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Dec 2018 02:48:20 -0500
MIME-Version: 1.0
References: <20181217193314.3487-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181217193314.3487-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Dec 2018 08:48:06 +0100
Message-ID: <CAMuHMdWJE9gu1LJbBz1++VxF9VkO8_Xkvc368BriXhcR6z88zQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: add documentation for PM usage
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Kieran Bingham <kbingham@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Mon, Dec 17, 2018 at 9:36 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add the first rule we recently agreed on.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/watchdog/watchdog-pm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/watchdog/watchdog-pm.txt
>
> diff --git a/Documentation/watchdog/watchdog-pm.txt b/Documentation/watchdog/watchdog-pm.txt
> new file mode 100644
> index 000000000000..7a4dd46e0d24
> --- /dev/null
> +++ b/Documentation/watchdog/watchdog-pm.txt
> @@ -0,0 +1,19 @@
> +The Linux WatchDog Timer Power Management Guide
> +===============================================
> +Last reviewed: 17-Dec-2018
> +
> +Wolfram Sang <wsa+renesas@sang-engineering.com>
> +
> +Introduction
> +------------
> +This document states rules about watchdog devices and their power management
> +handling to ensure a uniform behaviour for Linux systems.
> +
> +
> +Ping on resume
> +--------------
> +On resume, a watchdog timer shall be reset to its selected value to give
> +userspace enough time to resume. [1] [2]
> +
> +[1] https://patchwork.kernel.org/patch/10252209/
> +[2] https://patchwork.kernel.org/patch/10711625/

Is patchwork content preserved eternally?
I would use a link to lore.kernel.org instead, except that the above two threads
can't be found (while they should).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
