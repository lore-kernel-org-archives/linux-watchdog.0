Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCADC433FE
	for <linux-watchdog@archiver.kernel.org>; Sat,  8 Oct 2022 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJHUpI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 8 Oct 2022 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHUpH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Oct 2022 16:45:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DE1C426;
        Sat,  8 Oct 2022 13:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 289E9B80BEA;
        Sat,  8 Oct 2022 20:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6834CC433D7;
        Sat,  8 Oct 2022 20:44:57 +0000 (UTC)
Date:   Sat, 8 Oct 2022 16:44:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221008164451.738c912c@rorschach.local.home>
In-Reply-To: <20221008174602.3972859-1-u.kleine-koenig@pengutronix.de>
References: <20221008174602.3972859-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sat,  8 Oct 2022 19:46:02 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> To simplify debugging which process touches a watchdog and when, add
> tracing events for .start(), .set_timeout(), .ping() and .stop().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v2 sent with Message-Id:
> 20221004091950.3419662-1-u.kleine-koenig@pengutronix.de:
> 
>  - Reorder events in the header to have all DEFINE_EVENTS near their
>    DECLARE_EVENT_CLASS.
> 

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

