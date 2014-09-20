Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37790 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbaITQLX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 12:11:23 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVNFq-003UqX-RZ
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 16:11:22 +0000
Message-ID: <541DA6F9.8070601@roeck-us.net>
Date: Sat, 20 Sep 2014 09:10:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v3 1/4] ARM: docs: add documentation binding for meson
 watchdog
References: <1411158989-8075-1-git-send-email-carlo@caione.org>	<1411158989-8075-2-git-send-email-carlo@caione.org>	<541D9D20.6080503@roeck-us.net> <CAOQ7t2bBA3kW59z++Ewjch9+iTTzf7f0kE_9sytgLGqDAq3COQ@mail.gmail.com>
In-Reply-To: <CAOQ7t2bBA3kW59z++Ewjch9+iTTzf7f0kE_9sytgLGqDAq3COQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/20/2014 09:08 AM, Carlo Caione wrote:
> On Sat, Sep 20, 2014 at 5:28 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/19/2014 01:36 PM, Carlo Caione wrote:
>>>
>>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>> ---
>>>    Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13
>>> +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>>> b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>>> new file mode 100644
>>> index 0000000..9200fc2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>>> @@ -0,0 +1,13 @@
>>> +Meson SoCs Watchdog timer
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : should be "amlogic,meson6-wdt"
>>> +- reg : Specifies base physical address and size of the registers.
>>> +
>>
>>
>> The 'amlogic' vendor prefix is undefined.
>> It will have to be added to
>> Documentation/devicetree/bindings/vendor-prefixes.txt.
>
> As stated in the cover, this patchset depends on
> http://www.spinics.net/lists/arm-kernel/msg362521.html where the
> vendor-prefixes.txt is updated.
> Probably I should ping it.
>
Ah, sorry, I missed that.

Thanks,
Guenter

