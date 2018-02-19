Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34638 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeBSOqf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Feb 2018 09:46:35 -0500
Received: by mail-wm0-f51.google.com with SMTP id a20so433628wmd.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Feb 2018 06:46:34 -0800 (PST)
Message-ID: <1519051592.3951.2.camel@arista.com>
Subject: Re: [PATCH] i6300esb: fix build failure
From: Radu Rendec <rrendec@arista.com>
To: Matteo Croce <mcroce@redhat.com>
Cc: linux-watchdog@vger.kernel.org
Date: Mon, 19 Feb 2018 14:46:32 +0000
In-Reply-To: <20180219010105.25037-1-mcroce@redhat.com>
References: <20180219010105.25037-1-mcroce@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2018-02-19 at 02:01 +0100, Matteo Croce wrote:
> i6300esb uses fuctions defined in watchdog_core.c, and when
> CONFIG_WATCHDOG_CORE is not set we have this build error:

Hi Matteo,

Thanks for fixing this. FYI, the xen_wdt driver has a similar problem
and I just sent a patch to linux-watchdog.

Best regards,
Radu Rendec

