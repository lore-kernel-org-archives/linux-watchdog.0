Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:39518 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbaKRXM4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Nov 2014 18:12:56 -0500
Received: by mail-vc0-f170.google.com with SMTP id hq12so9958542vcb.1
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Nov 2014 15:12:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
Date: Tue, 18 Nov 2014 15:12:54 -0800
Message-ID: <CAL1qeaGgs0CrWdUV8kYVxbJ-=46+Xhx__pZy390iX0OXTF1bHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
From: Andrew Bresticker <abrestic@chromium.org>
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Naidu,

On Tue, Nov 18, 2014 at 4:07 AM,  <Naidu.Tellapati@imgtec.com> wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>
> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

checkpatch reports that there's trailing whitespace and that you're
using DOS line endings.  Please be sure to fix that with this and your
other patches.
