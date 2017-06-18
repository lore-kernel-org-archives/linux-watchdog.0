Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35243 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbdFROFu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 18 Jun 2017 10:05:50 -0400
Date: Sun, 18 Jun 2017 09:05:38 -0500
From: Rob Herring <robh@kernel.org>
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        yamada.masahiro@socionext.com, hayashi.kunihiko@socionext.com,
        owada.kiyoshi@socionext.com
Subject: Re: [PATCH V4 1/3] dt-bindings: watchdog: add description for
 UniPhier WDT controller
Message-ID: <20170617002642.rzo2bvm22ko3q22a@rob-hp-laptop>
References: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
 <1497426825-25450-2-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497426825-25450-2-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 14, 2017 at 04:53:43PM +0900, Keiji Hayashibara wrote:
> Add uniphier-wdt dt-bindings documentation.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/watchdog/uniphier-wdt.txt    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt

Acked-by: Rob Herring <robh@kernel.org>
