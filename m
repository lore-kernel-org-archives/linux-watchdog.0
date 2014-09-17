Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58466 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaIQHtM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 03:49:12 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp4so764802obc.8
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Sep 2014 00:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1410900217-5162-1-git-send-email-carlo@caione.org>
References: <1410900217-5162-1-git-send-email-carlo@caione.org>
Date: Wed, 17 Sep 2014 09:49:11 +0200
Message-ID: <CAOQ7t2anpGmj536CJTJuMWQ=Q_X-W5F_AWB1fjcXiVxh1EiNFw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: meson: watchdog driver
From: Carlo Caione <carlo@caione.org>
To: Carlo Caione <carlo@caione.org>
Cc: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 16, 2014 at 10:43 PM, Carlo Caione <carlo@caione.org> wrote:
> This patchset adds support for the watchdog found on Amlogic MesonX SoCs. The
> watchdog is used also to reboot the device.

<cut>

Ok, I missed the restart handler call chain.
I'll submit a v2 soon. Sorry for the noise.

-- 
Carlo Caione
