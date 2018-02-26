Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43141 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbeBZOcg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Feb 2018 09:32:36 -0500
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
To: Arnd Bergmann <arnd@arndb.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
 <20180226032227.14615-3-jerry.hoemann@hpe.com>
 <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <03b13d44-9ce3-ead8-020d-4b1b8114079d@roeck-us.net>
Date: Mon, 26 Feb 2018 06:32:30 -0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
> On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>> Gen8 and prior Proliant systems supported the "CRU" interface
>> to firmware.  This interfaces allows linux to "call back" into firmware
>> to source the cause of an NMI.  This feature isn't fully utilized
>> as the actual source of the NMI isn't printed, the driver only
>> indicates that the source couldn't be determined when the call
>> fails.
>>
>> With the advent of Gen9, iCRU replaces the CRU. The call back
>> feature is no longer available in firmware.  To be compatible and
>> not attempt to call back into firmware on system not supporting CRU,
>> the SMBIOS table is consulted to determine if it is safe to
>> make the call back or not.
>>
>> This results in about half of the driver code being devoted
>> to either making CRU calls or determing if it is safe to make
>> CRU calls.  As noted, the driver isn't really using the results of
>> the CRU calls.
>>
>> Furthermore, as a consequence of the Spectre security issue, the
>> BIOS/EFI calls are being wrapped into Spectre-disabling section.
>> Removing the call back in hpwdt_pretimeout assists in this effort.
>>
>> As the CRU sourcing of the NMI isn't required for handling the
>> NMI and there are security concerns with making the call back, remove
>> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
>> the system had the CRU interface.
>>
>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> This avoids a warning in mainline kernels, so that's great:
> 
> drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
> found in RETPOLINE build
> 
> I wonder what we do about stable kernels. Are both this patch and the patch
> that added the objtool warning message candidates for backports to
> stable kernels?
> 

Makes sense to me, but it is really a bit more than a bug fix, so I'll
leave it up to Jerry/HPE to make the call in respect to hpwdt.

Guenter
