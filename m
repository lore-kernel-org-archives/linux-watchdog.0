Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54083 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaISIHw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 04:07:52 -0400
Received: by mail-oa0-f50.google.com with SMTP id jd19so1461585oac.37
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Sep 2014 01:07:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140917205827.GA5269@gmail.com>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
	<1410984726-18944-2-git-send-email-carlo@caione.org>
	<20140917205827.GA5269@gmail.com>
Date: Fri, 19 Sep 2014 10:07:51 +0200
Message-ID: <CAOQ7t2Y4JAvs97UYONd1K3Lchps8w+RqavnT0D1R8gbgrCVd6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: docs: add documentation binding for meson watchdog
From: Carlo Caione <carlo@caione.org>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: Carlo Caione <carlo@caione.org>,
	Guenter Roeck <linux@roeck-us.net>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 17, 2014 at 10:58 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> On Wed, Sep 17, 2014 at 10:12:03PM +0200, Carlo Caione wrote:
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>> new file mode 100644
>> index 0000000..e66c0c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>> @@ -0,0 +1,13 @@
>> +Meson SoCs Watchdog timer
>> +
>> +Required properties:
>> +
>> +- compatible : should be "amlogic,meson-wdt"
>
> Hi Carlo,
>
> the compatible property should describe a specific version of the
> device, so maybe "amlogic,meson6-wdt" would be more appropriate.

Agree. Fix in v3.

Thanks,

-- 
Carlo Caione
