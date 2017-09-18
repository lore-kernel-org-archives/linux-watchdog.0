Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:37686 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdIRWbN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Sep 2017 18:31:13 -0400
Date: Mon, 18 Sep 2017 17:31:11 -0500
From: Rob Herring <robh@kernel.org>
To: Eric Long <eric.long@spreadtrum.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>, baolin.wang@linaro.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Spreadtrum watchdog
 documentation
Message-ID: <20170918223111.ywopvesfqodxh2ah@rob-hp-laptop>
References: <f3daa0f85dda0672c4b057e7f37c690365652e39.1505216059.git.eric.long@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3daa0f85dda0672c4b057e7f37c690365652e39.1505216059.git.eric.long@spreadtrum.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 12, 2017 at 07:40:08PM +0800, Eric Long wrote:
> This patch adds the documentation for Spreadtrum watchdog driver.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> ---
> changes since v1:
>  - No updates.
> ---
>  .../devicetree/bindings/watchdog/sprd-wdt.txt         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt

Acked-by: Rob Herring <robh@kernel.org>
