Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41316 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeIOTFQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 15 Sep 2018 15:05:16 -0400
Date: Sat, 15 Sep 2018 15:46:01 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
Message-ID: <20180915134601.GA947@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-2-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180914101339.7382-2-romain.izard.pro@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 14, 2018 at 12:13:38PM +0200, Romain Izard wrote:
> When using watchdog_init_timeout to update the default timeout value,
> an error means that there is no "timeout-sec" in the relevant device
> tree node.
>=20
> This should not prevent binding of the driver to the device.
>=20
> Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provide=
d in devicetree")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
