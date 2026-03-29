import { Agent } from '@openai/agents';
import { Memory } from '@openai/agents/memory';
import { Tool } from '@openai/agents/tools';

const agent = new Agent({
  name: '{{name}}',
  instructions: 'You are a helpful AI assistant.',
  tools: [
    // Add your tools here
  ],
  memory: new Memory({
    storage: 'sqlite',
  }),
});

export default agent;

if (require.main === module) {
  agent.start();
}