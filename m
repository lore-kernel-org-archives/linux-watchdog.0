Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65278 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbaGMJwo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 Jul 2014 05:52:44 -0400
Message-ID: <53C25551.1050909@nod.at>
Date: Sun, 13 Jul 2014 11:45:53 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>
CC: Chen Gang <gang.chen.5i5j@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
	jic23@kernel.org, wim@iguana.be,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	kys@microsoft.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	teg@jklm.no, Mischa.Jonker@synopsys.com, msalter@redhat.com,
	lars@metafoo.de, knaack.h@gmx.de, rdunlap@infradead.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-watchdog@vger.kernel.org, Liqin Chen <liqin.linux@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
References: <53C1F7DE.3060102@gmail.com>	<201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
In-Reply-To: <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Am 13.07.2014 11:27, schrieb Lennox Wu:
> As I said before, some configurations don't make sense.

If such a configuration can be achieved using allmod/yesconfig it has to be fixed.
Chen's fixes seem reasonable as not all architectures support iomem.

Thanks,
//richard
