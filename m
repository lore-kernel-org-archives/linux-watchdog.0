Return-path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1464943007-18000-1-git-send-email-narmstrong@baylibre.com>
 <1464943007-18000-2-git-send-email-narmstrong@baylibre.com>
 <575316A6.9080403@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <57552AD9.7040903@baylibre.com>
Date: Mon, 6 Jun 2016 09:48:41 +0200
MIME-Version: 1.0
In-Reply-To: <575316A6.9080403@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 06/04/2016 07:57 PM, Guenter Roeck wrote:
> On 06/03/2016 01:36 AM, Neil Armstrong wrote:
[...]
>> +++ b/drivers/watchdog/meson_gxbb_wdt.c
>> @@ -0,0 +1,268 @@
>> +/*
>> + * This file is provided under a dual BSD/GPLv2 license.  When using or
>> + * redistributing this file, you may do so under either license.
>> + *
>> + * GPL LICENSE SUMMARY
>> + *
>> + * Copyright (c) 2016 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + * The full GNU General Public License is included in this distribution
>> + * in the file called COPYING.
>> + *
>> + * BSD LICENSE
>> + *
>> + * Copyright (c) 2016 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
> Nitpick, but you don't really need the copyright and author lines twice.

Sorry, but I was asked to use this particular header format since I am not
the copyright holder of this file.

> 
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + *
>> + *   * Redistributions of source code must retain the above copyright
>> + *     notice, this list of conditions and the following disclaimer.
>> + *   * Redistributions in binary form must reproduce the above copyright
>> + *     notice, this list of conditions and the following disclaimer in
>> + *     the documentation and/or other materials provided with the
>> + *     distribution.
>> + *   * Neither the name of Intel Corporation nor the names of its
>> + *     contributors may be used to endorse or promote products derived
>> + *     from this software without specific prior written permission.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */

Thanks,
Neil
